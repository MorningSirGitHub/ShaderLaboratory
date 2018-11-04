using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class MotionBlurEffects : MonoBehaviour
{
    public Shader CurrentShader;
    // 屏幕分辨率
    private Vector4 ScreenResolution;
    private Material CurrentMaterial;

    [Range(5, 50)]
    public float InterationCount = 15;
    [Range(-0.5f, 0.5f)]
    public float Intensity = 0.125f;
    [Range(-2f, 2f)]
    public float OffsetX = 0.5f;
    [Range(-2f, 2f)]
    public float OffsetY = 0.5f;

    public static float ChangeValue1;
    public static float ChangeValue2;
    public static float ChangeValue3;
    public static float ChangeValue4;

    Material Material
    {
        get
        {
            if (CurrentMaterial == null)
            {
                CurrentMaterial = new Material(CurrentShader);
                CurrentMaterial.hideFlags = HideFlags.HideAndDontSave;
            }

            return CurrentMaterial;
        }
    }

    void Start()
    {
        ChangeValue1 = Intensity;
        ChangeValue2 = OffsetX;
        ChangeValue3 = OffsetY;
        ChangeValue4 = InterationCount;

        CurrentShader = Shader.Find("Morning/Vertex&FragmentShader/径向模糊特效标准版");

        // 判断是否支持屏幕特效
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }
    }

    /// <summary>
    /// 此函数在当完成所有渲染图片后被调用，用来渲染图片后期效果
    /// </summary>
    /// <param name="source">源纹理</param>
    /// <param name="destination">目标纹理</param>
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (CurrentShader != null)
        {
            // 设置Shader中的外部变量
            Material.SetFloat("_InterationCount", InterationCount);
            Material.SetFloat("_Value1", Intensity);
            Material.SetFloat("_Value2", OffsetX);
            Material.SetFloat("_Value3", OffsetY);
            Material.SetVector("_ScreenResolution", new Vector4(source.width, source.height, 0, 0));

            // 拷贝源纹理到目标渲染纹理，加上我们的材质效果
            Graphics.Blit(source, destination, Material);
        }
        else
        {
            // 着色器实例为空，直接拷贝屏幕上的效果。此情况下是没有实现屏幕特效的
            Graphics.Blit(source, destination);
        }
    }

    /// <summary>
    /// 将编辑器中的值赋值回来，确保在编辑器中值的改变立刻让结果生效
    /// </summary>
    void OnValidate()
    {
        ChangeValue1 = Intensity;
        ChangeValue2 = OffsetX;
        ChangeValue3 = OffsetY;
        ChangeValue4 = InterationCount;
    }

    void Update()
    {
        if (Application.isPlaying)
        {
            Intensity = ChangeValue1;
            OffsetX = ChangeValue2;
            OffsetY = ChangeValue3;
            InterationCount = ChangeValue4;
        }

#if UNITY_EDITOR
        if (Application.isPlaying != true)
        {
            CurrentShader = Shader.Find("Morning/Vertex&FragmentShader/径向模糊特效标准版");
        }
#endif
    }

    void OnDisable()
    {
        if (CurrentMaterial)
        {
            DestroyImmediate(CurrentMaterial);
        }
    }

}
