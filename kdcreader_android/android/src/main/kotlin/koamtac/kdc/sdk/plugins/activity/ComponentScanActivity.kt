package koamtac.kdc.sdk.plugins.activity

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.os.Bundle
import android.view.ViewGroup
import android.view.Window
import android.view.WindowManager
import android.widget.FrameLayout
import android.widget.RelativeLayout
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.honeywell.barcode.HSMDecodeResult
import com.honeywell.barcode.HSMDecoder
import com.honeywell.barcode.Symbology
import com.honeywell.plugins.decode.DecodeResultListener
import koamtac.kdc.sdk.KDCSWDecoderComponent

/* You can modify it to suit your requirements. */
class ComponentScanActivity: Activity() {
    companion object {
        private const val REQUEST_CAMERA_PERMISSION = 1
    }

    private lateinit  var contentLayout: RelativeLayout

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        window.setFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
            WindowManager.LayoutParams.FLAG_FULLSCREEN
        )

        requestWindowFeature(Window.FEATURE_NO_TITLE)

        contentLayout = RelativeLayout(this).apply {
            val params = RelativeLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT
            )
            layoutParams = params
        }

        // check permission
        val permission = ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA)
        if (permission == PackageManager.PERMISSION_GRANTED) {
            initHSMDecoder()
            val componentView = createComponentView()
            contentLayout.addView(componentView)
        } else {
            ActivityCompat.requestPermissions(
                this, arrayOf(Manifest.permission.CAMERA),
                REQUEST_CAMERA_PERMISSION
            )
        }
        setContentView(contentLayout)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when (requestCode) {
            REQUEST_CAMERA_PERMISSION -> {
                var i = 0
                while (i < permissions.size) {
                    val permission = permissions[i]
                    val grantResult = grantResults[i]
                    if (permission == Manifest.permission.CAMERA) {
                        if (grantResult == PackageManager.PERMISSION_GRANTED) {
                            contentLayout.removeAllViews()
                            val componentView = createComponentView()
                            contentLayout.addView(componentView)
                        } else {
                            Toast.makeText(this, "Camera Permission Required", Toast.LENGTH_LONG)
                                .show()
                            finish()
                        }
                    }
                    i++
                }
            }
        }
    }

    // It is possible to access HSMDecoder directly for advanced use.
    // Please refer to SwiftDecoder API document.
    private fun initHSMDecoder() {
/*
        val hsmDecoder = HSMDecoder.getInstance(this);

        // com.honeywell.barcode.Symbology
        hsmDecoder.enableSymbology(Symbology.CODABAR);
        hsmDecoder.enableSymbology(Symbology.QR);

        hsmDecoder.addResultListener(object : DecodeResultListener {
            override fun onHSMDecodeResult(hsmDecodeResults: Array<out HSMDecodeResult>?) {

            }
        });
*/
    }

    private fun createComponentView(): KDCSWDecoderComponent {
        val componentView = KDCSWDecoderComponent(this)
        val layoutParams = FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT
        )
        componentView.layoutParams = layoutParams
        return componentView
    }
}