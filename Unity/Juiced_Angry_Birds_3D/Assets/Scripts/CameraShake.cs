using System.Collections;
using UnityEngine;

public class CameraShake : MonoBehaviour {
   public IEnumerator shake(float duration, float magnitude) {
       Vector3 originalPos=transform.localPosition;
       float elapsed=0.0f;
       while (elapsed < duration) {
           float y=Random.Range(-1f, 1f) * magnitude;
           float z=Random.Range(-1f, 1f) * magnitude;
           elapsed += Time.deltaTime;
           transform.localPosition = new Vector3(originalPos.x, y, z); 
           yield return null;
        }
        transform.localPosition=originalPos;
   }
}
