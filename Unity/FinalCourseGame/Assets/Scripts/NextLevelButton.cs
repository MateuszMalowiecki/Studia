using UnityEngine;
using UnityEngine.SceneManagement;

public class NextLevelButton : MonoBehaviour {
   private void OnMouseDown() {
        if (GameManager.instance.SceneName == "Level1") {
            SceneManager.LoadScene("Level2");
        }
        else {
            SceneManager.LoadScene("Level3");
        }
    }
}
