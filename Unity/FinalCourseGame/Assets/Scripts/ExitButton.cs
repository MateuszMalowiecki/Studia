using UnityEngine;
using UnityEngine.SceneManagement;

public class ExitButton : MonoBehaviour {
    private void OnMouseDown() {
        SceneManager.LoadScene("MainMenu");
    } 
}