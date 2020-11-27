using UnityEngine;
using UnityEngine.SceneManagement;

public class Enemy3D : MonoBehaviour {
    public static float enemiesAlive=0;
    public float health=4f;
    public GameObject deathEffect;
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
