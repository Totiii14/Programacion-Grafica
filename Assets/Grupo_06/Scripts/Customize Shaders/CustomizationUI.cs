using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class CustomizationUI : MonoBehaviour
{
    public GameObject floatSliderPrefab;
    public GameObject vector2SliderPrefab;

    public Transform slidersContainer;
    private CustomizableObject currentObject;

    public void ShowSlidersForObject(CustomizableObject obj)
    {
        currentObject = obj;

        foreach (Transform child in slidersContainer)
            Destroy(child.gameObject);

        foreach (MaterialProperty prop in obj.properties)
        {
            switch (prop.type)
            {
                case PropertyType.Float:
                    CreateFloatSlider(obj.material, prop.name);
                    break;
                case PropertyType.Vector2:
                    CreateVector2Sliders(obj.material, prop.name);
                    break;
            }
        }
    }

    private void CreateFloatSlider(Material mat, string propName)
    {
        GameObject go = Instantiate(floatSliderPrefab, slidersContainer);
        Slider slider = go.GetComponent<Slider>();
        slider.value = mat.GetFloat(propName);
        slider.onValueChanged.AddListener(val => mat.SetFloat(propName, val));

        TMP_Text label = go.GetComponentInChildren<TMP_Text>();
        if (label != null)
            label.text = propName;
    }

    private void CreateVector2Sliders(Material mat, string propName)
    {
        GameObject go = Instantiate(vector2SliderPrefab, slidersContainer);
        Slider[] sliders = go.GetComponentsInChildren<Slider>();
        Vector2 vec = mat.GetVector(propName);

        sliders[0].value = vec.x;
        sliders[1].value = vec.y;

        sliders[0].onValueChanged.AddListener(val =>
        {
            vec.x = val; mat.SetVector(propName, vec);
        });
        sliders[1].onValueChanged.AddListener(val =>
        {
            vec.y = val; mat.SetVector(propName, vec);
        });

        TMP_Text label = go.GetComponentInChildren<TMP_Text>();
        if (label != null)
            label.text = propName;
    }

    public void Hide()
    {
        foreach (Transform child in slidersContainer)
            Destroy(child.gameObject);
        currentObject = null;
    }
}
