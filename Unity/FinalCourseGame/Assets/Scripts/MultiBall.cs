using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MultiBall : Collectables {
    protected override void ApplyEffect() {
      GameManager.instance.pointsFromLevel += 10;
    }
}
