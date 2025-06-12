using UnityEngine;

[System.Serializable]
public class MaterialProperty
{
    public string name;
    public PropertyType type;
}

public enum PropertyType
{
    Float,
    Vector2
}

public class CustomizableObject : MonoBehaviour
{
    public Material material;

    public MaterialProperty[] properties;

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);
    }
}
