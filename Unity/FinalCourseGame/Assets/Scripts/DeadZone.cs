using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DeadZone : MonoBehaviour
{
    void OnTriggerEnter(Collider other) {
        if (other.name=="Ball") {
            ball destroyed_ball = other.GetComponent<ball>();
            //BallManager.instance.balls.Remove(destroyed_ball);
            //if (BallManager.instance.balls.Count == 0) {
            GameManager.instance.LoseLife();
            //}
        }
    }
}
