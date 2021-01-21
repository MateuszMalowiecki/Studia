using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MultiBall : Collectables {
    protected override void ApplyEffect() {
      GameManager.instance.pointsFromLevel += 10;
      /*foreach (ball b in BallManager.instance.balls) {
        BallManager.instance.SpawnBalls(b.gameObject.transform.position);   
      }*/
    }
}
