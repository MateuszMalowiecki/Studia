using UnityEngine;
using UnityEngine.SceneManagement;

public class BackToMenu : MonoBehaviour {
    private void OnMouseDown() {
        SceneManager.LoadScene("Menu");
    } 
}
