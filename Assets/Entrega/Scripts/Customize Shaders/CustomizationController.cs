using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CustomizationController : MonoBehaviour
{
    public Camera cam;
    public CustomizationUI customizationUI;
    CustomizableObject[] objects;

    private void Start()
    {
        objects = FindObjectsOfType<CustomizableObject>();
        for (int i = 0; i < objects.Length; i++)
        {
            customizationUI.ShowSlidersForObject(objects[i]);
        }
    }
}
