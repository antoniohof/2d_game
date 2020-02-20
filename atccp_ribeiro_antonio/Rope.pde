// just a rope joint to connect between two objects
class Rope {

  RopeJoint ropeJoint;
  Rope() {
    ropeJoint = null;
  }

  void bind(Body a, Body b) {
    box2d.world.step(0, 0, 0);

    RopeJointDef md = new RopeJointDef();
    md.bodyA = b;
    md.bodyB = a;
    md.maxLength = box2d.scalarPixelsToWorld(30.0);
    md.collideConnected = false;
    // Make the joint!
    ropeJoint = (RopeJoint) box2d.world.createJoint(md);
  }

  boolean destroy() {
    box2d.world.step(0, 0, 0);
    if (ropeJoint != null) {
      if (!box2d.world.isLocked()) {
        box2d.world.destroyJoint(ropeJoint);
        ropeJoint = null;
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
