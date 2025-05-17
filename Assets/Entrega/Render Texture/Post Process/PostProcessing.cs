using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[System.Serializable]
public class PostProcessMaterial
{
    public string name;
    public Slider slider;
}

//[ExecuteAlways]
[RequireComponent(typeof (Camera))]
public class PostProcessing : MonoBehaviour
{

    [SerializeField] List<PostProcessMaterial> postProcessMaterials = new List<PostProcessMaterial>();
    [SerializeField] Material material;

    private void Update()
    {
        float post = 0;

        for (int i = 0; i < postProcessMaterials.Count; i++)
        {
            post = postProcessMaterials[i].slider.value;
        }
        float valueGray = material.GetFloat("_Grayscale");
        
        valueGray = post;

        material.SetFloat("_Grayscale", valueGray);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);
    }
}
