using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CustomizationController : MonoBehaviour
{
    public Camera cam;
    public CustomizationUI customizationUI;

    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = cam.ScreenPointToRay(Input.mousePosition);
            if (Physics.Raycast(ray, out RaycastHit hit))
            {
                CustomizableObject customizable = hit.collider.GetComponent<CustomizableObject>();
                if (customizable != null)
                {
                    customizationUI.ShowSlidersForObject(customizable);
                }
                else
                {
                    customizationUI.Hide();
                }
            }
        }
    }
}
