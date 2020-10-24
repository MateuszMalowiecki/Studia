using UnityEngine;

public class EndTrigger : MonoBehaviour
{
    public GameManager gm;
    void OnTriggerEnter()
    {
        gm.CompleteLevel();
    }
}
