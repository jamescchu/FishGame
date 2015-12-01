class Utilities {

  Utilities() {
  }

  float heading(Vec2 v) {
    float angle = (float) Math.atan2(-v.y, v.x);
    return -1*angle;
  }

  float length(Vec2 v) {
    return MathUtils.sqrt(v.x * v.x + v.y * v.y);
  }

  Vec2 fromAngle(float angle) {
    return fromAngle(angle, null);
  }

  Vec2 fromAngle(float angle, Vec2 target) {
    if (target == null) {
      target = new Vec2((float)Math.cos(angle), (float)Math.sin(angle));
    } else {
      target.set((float)Math.cos(angle), (float)Math.sin(angle));
    }
    return target;
  }

  Vec2 sub(Vec2 v1, Vec2 v2) {
    return sub(v1, v2, null);
  }

  Vec2 sub(Vec2 v1, Vec2 v2, Vec2 target) {
    if (target == null) {
      target = new Vec2(v1.x - v2.x, v1.y - v2.y);
    } else {
      target.set(v1.x - v2.x, v1.y - v2.y);
    }
    return target;
  }

  void limit(Vec2 v, float max) {
    if (v.length() > max*max) {
      v.normalize();
      v.mulLocal(max);
    }
  }
}