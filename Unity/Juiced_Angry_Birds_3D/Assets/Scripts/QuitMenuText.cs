using UnityEngine;
using UnityEngine.UI;

public class QuitMenuText : MonoBehaviour {
    public Text scoreText;
    void Start() {
        scoreText.text="You won with "+ Score.pointSum +" points";
        Score.pointSum=0;
        Score.points=0;
    } 
}