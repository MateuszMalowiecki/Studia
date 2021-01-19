using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DeadZone : MonoBehaviour
{
    void OnTriggerEnter(Collider other) {
        if (other.name=="Ball") {
            GameManager.instance.LoseLife();
        }
    }
}
