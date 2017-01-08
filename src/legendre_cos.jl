using Logging
@Logging.configure(level=INFO)

legendre_polynomials = Dict()

function legendre_cos_0_0(cos_theta::Number)
    return 1
end
legendre_polynomials[(0,0)] = legendre_cos_0_0

function legendre_cos_1_0(cos_theta::Number)
    return cos_theta
end
legendre_polynomials[(1,0)] = legendre_cos_1_0

# Pn,m(z) = ((n-(m-1))zPn,m-1(z) - (n+m-1)Pn-1,m-1(z))/(sqrt(1-z^2))
function legendre_construct_order_and_degree_down(n, m, legendre_cos_n_mminusone, legendre_cos_nminusone_mminusone)
    return function(cos_theta::Number)
        @debug("cos_theta: $cos_theta")
        return ((n-m-1) * cos_theta * legendre_cos_n_mminusone(cos_theta) -
                (n+m-1) * legendre_cos_nminusone_mminusone(cos_theta)) /
               (sqrt(1 - cos_theta ^ 2))
    end
end

# Pn,m(z) = ((2(n-1)+1)zPn-1,m(z) - (n-1+m)(Pn-2,m(z))/((n-1)-m+1)
function legendre_construct_order_down_two_keep_degree(n, m, legendre_cos_nminusone_m, legendre_cos_nminustwo_m)
    return function(cos_theta::Number)
        @debug("cos_theta: $cos_theta")
        return ((2 * (n-1) + 1) * cos_theta * legendre_cos_nminusone_m(cos_theta) -
                (n-1+m) * legendre_cos_nminustwo_m(cos_theta)) /
               ((n-1)-m+1)
    end
end

function get_legendre_function(n, m)
    @debug("get_legendre_function($n, $m)")
    if m > n
        error("Degree ($m) must be <= order ($n)")
    end

    # First check if this order and degree is already cached
    fn = get(legendre_polynomials, (n, m), Void)
    if fn != Void
      return fn
    end

    # If we haven't already cached it, then we need to construct it.

    # The two base functions are both of degree zero, so we can directly construct any higher
    # order functions based on zero degree predecessors. That is, if we're already
    # requesting a function of degree zero, then we use the two lower order functions
    # to construct it.
    if m == 0
        # Get (or construct) lower order functions
        legendre_cos_nminustwo_m = get_legendre_function(n-2, m)
        legendre_cos_nminusone_m = get_legendre_function(n-1, m)

        # Construct the function of this order
        fn = legendre_construct_order_down_two_keep_degree(n, m, legendre_cos_nminusone_m, legendre_cos_nminusone_m)

        # Cache this function for future use
        legendre_polynomials[(n,m)] = fn

        # All done
        return fn
    end

    # If we aren't requesting a function of degree zero, then we construct it using
    # fuctions of lower degree and of lower order, effectively traversing diagonally
    # up the order + degree triangle, until we reach functions of order zero. Once we
    # reach functions of degree zero, then we can traverse vertically up to the two
    # base functions
    
    # Get (or construct) lower order and degree functions
    legendre_cos_n_mminusone = get_legendre_function(n, m-1)
    legendre_cos_nminusone_mminusone = get_legendre_function(n-1, m-1)
    
    # Construct the function of this order and degree
    fn = legendre_construct_order_and_degree_down(n, m, legendre_cos_n_mminusone, legendre_cos_nminusone_mminusone)

    # Cache this function for future use
    legendre_polynomials[(n,m)] = fn

    # All done
    return fn
end

function legendre_cos(order::Int, degree::Int, theta::Number)
    fn = get_legendre_function(order, degree)
    cos_theta = cos(theta)
    return fn(cos_theta)
end
