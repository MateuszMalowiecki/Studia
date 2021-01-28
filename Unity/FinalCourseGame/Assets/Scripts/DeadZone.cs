using UnityEngine;

public class DeadZone : MonoBehaviour {
    void OnTriggerEnter(Collider other) {
        if (other.name=="Ball") {
            GameManager.instance.LoseLife();
        }
    }
}
