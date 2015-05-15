using UnityEngine;
using System;
using System.Runtime.InteropServices;

public class TransVibrator
{
#if UNITY_EDITOR_OSX || UNITY_STANDALONE_OSX
		[DllImport ("TransVibratorPlugin")]
		private static extern void InitializePlugin ();

		[DllImport ("TransVibratorPlugin")]
		public static extern void DeinitializePlugin ();

		[DllImport ("TransVibratorPlugin")]
		private static extern int CountInternal ();

		[DllImport ("TransVibratorPlugin")]
		private static extern void VibrateInternal (int index, byte strength);

		private static bool isInitialized = false;

		private static void Initialize ()
		{
				if (isInitialized) {
						return;
				}

				InitializePlugin ();

				GameObject internalGameObject = new GameObject ();
				internalGameObject.name = "__TransVibratorInternal";
				internalGameObject.AddComponent <TransVibratorInternal>();

				isInitialized = true;
		}

		public static int Count {
				get {
						Initialize ();
						return CountInternal ();
				}
		}

		public static void Vibrate (int index, float strength)
		{
				Initialize ();
				VibrateInternal (index, (byte)(Mathf.Clamp01 (strength) * 255.0f));
		}

		public static void VibrateAll (float strength)
		{
				Initialize ();
				VibrateInternal (-1, (byte)(Mathf.Clamp01 (strength) * 255.0f));
		}
#else
	public static int Count {
		get {
			return 0;
		}
	}
	
	public static void Vibrate (int index, float strength)
	{
	}
	
	public static void VibrateAll (float strength)
	{
	}
#endif
}
