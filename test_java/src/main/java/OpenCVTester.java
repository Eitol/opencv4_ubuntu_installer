import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;

public class OpenCVTester {
    private static final String TEST_FILE = "src/test/resources/mila_kunis.jpg";

    public static void main(String[] args) {
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        System.out.println("Running");
        Mat image = Imgcodecs.imread(TEST_FILE);
        Mat gray = new Mat();
        Imgproc.cvtColor(image, gray, Imgproc.COLOR_RGB2GRAY);
    }
}
