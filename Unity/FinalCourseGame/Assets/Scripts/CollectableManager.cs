using System.Collections.Generic;
using UnityEngine;

public class CollectableManager : MonoBehaviour {
    public static CollectableManager instance;

    private void Start() {
        if (instance == null) {
            instance = this;
        }
        else {
            Destroy(gameObject);
        }
    }

    public List<Collectables> AvailableBuffs;

    [Range(0, 100)]
    public float BuffChance;
}
