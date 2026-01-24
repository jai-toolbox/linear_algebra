Math:: #import "Math";

#import "turns";
#import "math";

// @todo are we going clockwise or counter clockwise?
rotate_turns :: (v : Math.Vector2, t: float, r_dir : Rotation_Direction = .CCW) -> Math.Vector2 {
    if (r_dir == .CW) t *= -1;
    if (t == one_quarter_turn) {
        return .{-v.y, v.x};
    } else if (t == -one_quarter_turn) { 
        return .{v.y, -v.x};
    } else if (t == one_half_turn || t == -one_half_turn) { 
        return .{-v.x, -v.y};
    } else if (t == 0.0 || t == full_turn || t == -full_turn) { 
        return v;
    }

    // general case
    cos_t := cos_turns(t);
    sin_t := sin_turns(t);

    // this is the result after doing matrix mult.
    return .{v.x * cos_t- v.y * sin_t, v.x * sin_t+ v.y * cos_t};
}

arbitrary_unit_perpendicular :: (v: Math.Vector3) -> Math.Vector3 {
    crosser: Math.Vector3;
    eps := 0.001;
    almost_aligned_with_y := Math.abs(v.x) <= eps && Math.abs(v.z) <= eps;
    if (almost_aligned_with_y) { // then use something not close to y
        crosser = X3;
    } else {
        crosser = Y3;
    }
    return normalized_cross(v, crosser);
}

