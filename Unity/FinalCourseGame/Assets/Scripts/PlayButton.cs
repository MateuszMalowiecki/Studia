using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayButton : MonoBehaviour { 
    private void OnMouseDown() {
        GameManager.pointsFromAllLevels=0;
        SceneManager.LoadScene("Level1");
    } 
}
