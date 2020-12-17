using UnityEngine;
using UnityEngine.SceneManagement;

public class Enemy3D : MonoBehaviour {
    public static float enemiesAlive=0;
    public float health=6f;
    public GameObject deathEffect;
    public CameraShake cameraShake;
    void Start() {
        enemiesAlive++;
    }
    void OnCollisionEnter(Collision colInfo) {
        if (colInfo.relativeVelocity.magnitude > health) {
            Die();
        }
    }
    void Die() {
        Destroy(gameObject);
        Instantiate(deathEffect, transform.position, Quaternion.identity);
        StartCoroutine(cameraShake.shake(0.35f, 0.4f));
        FindObjectOfType<Audiomanager>().Play("Death");
        enemiesAlive--;
        Score.points+=50;
        if (enemiesAlive == 0) {
            Score.pointSum+=Score.points;
            Score.points=0;
            if (GameManager.SceneName == "3DLevel3") {
                SceneManager.LoadScene("Quit_Menu");
            }
            else {
                SceneManager.LoadScene("Level Win Menu");
            }
        }
    }
}
