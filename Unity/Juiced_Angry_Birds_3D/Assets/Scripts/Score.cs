using UnityEngine;
using UnityEngine.UI;

public class Score : MonoBehaviour
{
    public static float points=0;
    public static float pointSum=0;
    public Text scoreText;

    // Update is called once per frame
    void Update()
    {
        scoreText.text=points.ToString();   
    }
}
