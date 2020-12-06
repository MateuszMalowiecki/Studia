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
        if (enemiesAlive == 0) {
            string sceneToLoad = "Quit_Menu"; 
            switch (GameManager.SceneName) {
                case "3DLevel": {
                    sceneToLoad="3DLevel2";
                    break;
                }
                case "3DLevel2": {
                    sceneToLoad="3DLevel3";
                    break;
                }
            }
            SceneManager.LoadScene(sceneToLoad);
        }
    }
}
