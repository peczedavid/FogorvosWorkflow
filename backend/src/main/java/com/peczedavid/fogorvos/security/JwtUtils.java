package com.peczedavid.fogorvos.security;

import io.jsonwebtoken.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

@Service
public class JwtUtils {
    Logger logger = LoggerFactory.getLogger(JwtUtils.class);

    @Value("${peczedavid.app.jwtSecret}")
    private String SECRET_KEY;

    @Value("${peczedavid.app.jwtExpirationMs}")
    private int JWT_EXPIRATION_MS;

    @Value("${peczedavid.app.jwtCookieName}")
    private String COOKIE_NAME;

    public String getJwtFromRequest(HttpServletRequest request) {
        Cookie cookie = WebUtils.getCookie(request, COOKIE_NAME);
        if (cookie == null) {
            logger.warn("No jwt cookie found in request.");
            return null;
        }
        return cookie.getValue();
    }

    public Cookie generaJwtCookie(UserDetailsImpl userDetailsImpl) {
        String jwt = generateToken(userDetailsImpl);
        Cookie cookie = new Cookie(COOKIE_NAME, jwt);
        cookie.setHttpOnly(true);
        cookie.setPath("/api");
        cookie.setMaxAge(JWT_EXPIRATION_MS / 1000);
        return cookie;
    }

    public Cookie generateLogutCookie() {
        Cookie cookie = new Cookie(COOKIE_NAME, "");
        cookie.setHttpOnly(true);
        cookie.setPath("/api");
        cookie.setMaxAge(0);
        return cookie;
    }

    public boolean isTokenValid(String token) {
        try {
            extractAllClaims(token);
            return !isTokenExpired(token);
        } catch (SignatureException e) {
            logger.error("Invalid JWT signature: {}", e.getMessage());
        } catch (MalformedJwtException e) {
            logger.error("Invalid JWT token: {}", e.getMessage());
        } catch (ExpiredJwtException e) {
            logger.error("JWT token is expired: {}", e.getMessage());
        } catch (UnsupportedJwtException e) {
            logger.error("JWT token is unsupported: {}", e.getMessage());
        } catch (IllegalArgumentException e) {
            logger.error("JWT claims string is empty: {}", e.getMessage());
        }
        return false;
    }

    public String generateToken(UserDetailsImpl userDetailsImpl) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", String.valueOf(userDetailsImpl.getId()));
        return createToken(claims, userDetailsImpl.getUsername());
    }

    public String getUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    public Date getExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    private Claims extractAllClaims(String token) {
        return Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token).getBody();
    }

    private boolean isTokenExpired(String token) {
        return getExpiration(token).before(new Date());
    }

    private String createToken(Map<String, Object> claims, String subject) {
        return Jwts.builder().setClaims(claims).setSubject(subject).setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + JWT_EXPIRATION_MS))
                .signWith(SignatureAlgorithm.HS512, SECRET_KEY).compact();
    }

}
