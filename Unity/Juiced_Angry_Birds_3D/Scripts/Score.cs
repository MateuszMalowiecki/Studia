using UnityEngine;
using UnityEngine.UI;

public class Score : MonoBehaviour
{
    //points from particular level
    public static float points=0;
    //points from all levels in single game
    public static float pointSum=0;
    public Text scoreText;

    void Update()
    {
        scoreText.text=points.ToString();   
    }
}
