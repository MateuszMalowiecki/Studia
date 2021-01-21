using System.Collections;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour {
    public int lives;
    public int bricks;
    public int pointsFromLevel;
    public static int pointsFromAllLevels;
    public float resetDelay;
    public Text livesText;
    public GameObject gameOver;
    public GameObject youWon;
    public GameObject brickPrefab;
    public GameObject paddle;
    public GameObject deathParticles;
    public static GameManager instance = null;
    private GameObject clonePaddle;
    public string SceneName;
    // Start is called before the first frame update
    void Start() {
        pointsFromLevel = 0;
        if (instance == null) {
            instance = this;
        }
        else if (instance != this) {
            Destroy(gameObject);
        }
        Setup();
    }
    public void Setup() {
        SceneName=SceneManager.GetActiveScene().name;
        lives=3;
        bricks=15;
        switch(SceneName) {
            case "Level2":
                bricks=21;
                break;
            case "Level3":
                bricks=23;
                break;
        }
        resetDelay=1f;
        clonePaddle = Instantiate(paddle, transform.position, Quaternion.identity) as GameObject;
        Instantiate(brickPrefab, transform.position + 2*Vector3.up, Quaternion.identity);
    }
    void CheckGameOver() {
        if (bricks < 1) {
            Invoke("WinLevel", resetDelay);
        }
        if (lives < 1) {
            Invoke("LoseLevel", resetDelay);
        }
    }
    void WinLevel() {
        pointsFromAllLevels += pointsFromLevel * lives;
        if (SceneName == "Level3") {
            SceneManager.LoadScene("Win");
        }
        else {
            SceneManager.LoadScene("LevelWonMenu");
        }
    }
    void LoseLevel() {
        SceneManager.LoadScene("GameOver");
    }
    public void LoseLife() {
        lives--;
        setText();
        Instantiate(deathParticles, clonePaddle.transform.position, Quaternion.identity);
        Destroy(clonePaddle);
        Invoke("SetupPaddle", resetDelay);
        CheckGameOver();
    }
    public void setText() {
        livesText.text = "Lives: " + lives + ", Points: " + pointsFromLevel;
    }
    void SetupPaddle() {
        clonePaddle = Instantiate(paddle, transform.position, Quaternion.identity) as GameObject;
    }
    public void DestroyBrick() {
        bricks--;
        CheckGameOver();
    }
}
