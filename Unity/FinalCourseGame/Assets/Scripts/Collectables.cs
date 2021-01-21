using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Collectables : MonoBehaviour
{
   private void OnTriggerEnter(Collider other) {
        if (other.name.StartsWith("Paddle")) {
            this.ApplyEffect();
            Destroy(this.gameObject);
        }
    }

    protected abstract void ApplyEffect();
}
