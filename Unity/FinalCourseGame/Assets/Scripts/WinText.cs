using UnityEngine;
using UnityEngine.UI;

public class WinText : MonoBehaviour{ 
    public Text scoreText;
    void Start() {
        scoreText.text="You won with "+ GameManager.pointsFromAllLevels +" points";
    } 
}
