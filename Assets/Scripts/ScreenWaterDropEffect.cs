using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu("Morning/屏幕水流特效")]
public class ScreenWaterDropEffect : MonoBehaviour
{
    public Shader CurrentShader;
    private Material CurrentMaterial;

    private float TimeX = 1.0f;
    private Texture2D ScreentWaterDropTex;

    [Range(5, 64), Tooltip("溶解度")]
    public float Distortion = 8.0f;
    [Range(0, 7), Tooltip("水滴 在X坐边上的尺寸")]
    public float SizeX = 1f;
    [Range(0, 7), Tooltip("水滴 在Y坐边上的尺寸")]
    public float SizeY = 0.5f;
    [Range(0, 10), Tooltip("水滴流动的速度")]
    public float DropSpeed = 3.6f;

    public static float ChangeDistortion;
    public static float ChangeSizeX;
    public static float ChangeSizeY;
    public static float ChangeDropSpeed;

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
        ChangeDistortion = Distortion;
        ChangeSizeX = SizeX;
        ChangeSizeY = SizeY;
        ChangeDropSpeed = DropSpeed;

        ScreentWaterDropTex = Resources.Load<Texture2D>("ScreenWater");

        CurrentShader = Shader.Find("Morning/Vertex&FragmentShader/屏幕水幕特效");

        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (CurrentShader != null)
        {
            TimeX += Time.deltaTime;

            if (TimeX > 100)
                TimeX = 0;

            Material.SetFloat("_CurrentTime", TimeX);
            Material.SetFloat("_Distortion", Distortion);
            Material.SetFloat("_SizeX", SizeX);
            Material.SetFloat("_SizeY", SizeY);
            Material.SetFloat("_DropSpeed", DropSpeed);
            Material.SetTexture("_WaterDropTex", ScreentWaterDropTex);

            Graphics.Blit(source, destination, Material);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }

    void OnValidate()
    {
        ChangeDistortion = Distortion;
        ChangeSizeX = SizeX;
        ChangeSizeY = SizeY;
        ChangeDropSpeed = DropSpeed;
    }

    void Update()
    {
        if (Application.isPlaying)
        {
            Distortion = ChangeDistortion;
            SizeX = ChangeSizeX;
            SizeY = ChangeSizeY;
            DropSpeed = ChangeDropSpeed;
        }

#if UNITY_EDITOR
        if (Application.isPlaying != true)
        {
            CurrentShader = Shader.Find("Morning/Vertex&FragmentShader/屏幕水幕特效");
            ScreentWaterDropTex = Resources.Load<Texture2D>("ScreenWater");
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
