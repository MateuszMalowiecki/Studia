using System;
using UnityEngine.Audio;
using UnityEngine;

public class Audiomanager : MonoBehaviour
{
    public Sound[] sounds;
    void Awake() {
        foreach(Sound s in sounds) {
            s.source= gameObject.AddComponent<AudioSource>();
            s.source.clip = s.clip;
        }
    }
    public void Play(String sound) {
        Sound s = Array.Find(sounds, item => item.name == sound);
        if (s == null) {
			Debug.LogWarning("Sound: " + sound + " not found!");
			return;
		}
        s.source.time=s.source.clip.length * .2f;
		s.source.Play();
    }
}
