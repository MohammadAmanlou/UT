#include <iostream>
#include <vector>
#include <cmath>
#include <sndfile.hh>

std::vector<double> readWavFile(const std::string& filename, int& sampleRate) {
    SndfileHandle file(filename);
    if (file.error()) {
        std::cerr << "Error opening file: " << filename << std::endl;
        exit(1);
    }

    sampleRate = file.samplerate();
    std::vector<double> signal(file.frames());
    file.read(&signal[0], file.frames());
    return signal;
}

void writeWavFile(const std::string& filename, const std::vector<double>& signal, int sampleRate) {
    SndfileHandle file(filename, SFM_WRITE, SF_FORMAT_WAV | SF_FORMAT_PCM_16, 1, sampleRate);
    if (file.error()) {
        std::cerr << "Error writing file: " << filename << std::endl;
        exit(1);
    }

    file.write(&signal[0], signal.size());
}

std::vector<double> applyBandPassFilter(const std::vector<double>& inputSignal, double deltaF, double samplingRate) {
    size_t N = inputSignal.size();
    std::vector<double> outputSignal(N, 0.0);

    for (size_t i = 0; i < N; ++i) {
        double f = i * samplingRate / N; // Frequency corresponding to index i
        double H = (f * f) / (f * f + deltaF * deltaF); // Band-pass formula
        outputSignal[i] = inputSignal[i] * H;
    }

    return outputSignal;
}

std::vector<double> applyNotchFilter(const std::vector<double>& inputSignal, double f0, double n, double samplingRate) {
    size_t N = inputSignal.size();
    std::vector<double> outputSignal(N, 0.0);

    for (size_t i = 0; i < N; ++i) {
        double f = i * samplingRate / N; // Frequency corresponding to index i
        double H = 1.0 / (std::pow(f / f0, 2 * n) + 1.0); // Notch filter formula
        outputSignal[i] = inputSignal[i] * H;
    }

    return outputSignal;
}

// FIR Filter Function
std::vector<double> applyFIRFilter(const std::vector<double>& inputSignal, const std::vector<double>& filterCoefficients) {
    size_t signalLength = inputSignal.size();
    size_t filterLength = filterCoefficients.size();
    std::vector<double> outputSignal(signalLength, 0.0);

    for (size_t n = 0; n < signalLength; ++n) {
        for (size_t k = 0; k < filterLength; ++k) {
            if (n >= k) { // Avoid negative indices
                outputSignal[n] += inputSignal[n - k] * filterCoefficients[k];
            }
        }
    }

    return outputSignal;
}

std::vector<double> applyIIRFilter(const std::vector<double>& inputSignal, const std::vector<double>& feedforwardCoefficients, const std::vector<double>& feedbackCoefficients) {
    size_t signalLength = inputSignal.size();
    size_t feedforwardLength = feedforwardCoefficients.size(); // M
    size_t feedbackLength = feedbackCoefficients.size();       // N
    std::vector<double> outputSignal(signalLength, 0.0);

    for (size_t n = 0; n < signalLength; ++n) {
        // Feedforward
        for (size_t k = 0; k < feedforwardLength; ++k) {
            if (n >= k) { // Avoid negative indices
                outputSignal[n] += feedforwardCoefficients[k] * inputSignal[n - k];
            }
        }

        // Feedback
        for (size_t j = 1; j < feedbackLength; ++j) {
            if (n >= j) { // Avoid negative indices
                outputSignal[n] -= feedbackCoefficients[j] * outputSignal[n - j];
            }
        }
    }

    return outputSignal;
}

int main() {

    int sampleRate;
    std::string inputFilename = "input.wav";
    std::string outputFilename = "output.wav";
    std::vector<double> signal = readWavFile(inputFilename, sampleRate);

    double deltaF = 100.0; 
    std::vector<double> bandPassSignal = applyBandPassFilter(signal, deltaF, sampleRate);

    double f0 = 50.0;
    double n = 2.0;  
    std::vector<double> notchSignal = applyNotchFilter(bandPassSignal, f0, n, sampleRate);

    std::vector<double> firCoefficients = {0.1, 0.2, 0.3, 0.2, 0.1}; 
    std::vector<double> firSignal = applyFIRFilter(notchSignal, firCoefficients);

    std::vector<double> iirFeedforward = {0.1, 0.2, 0.3}; 
    std::vector<double> iirFeedback = {1.0, -0.4, 0.3};  
    std::vector<double> iirSignal = applyIIRFilter(firSignal, iirFeedforward, iirFeedback);

    writeWavFile(outputFilename, iirSignal, sampleRate);

    std::cout << "Processing complete. Output saved to " << outputFilename << std::endl;

    return 0;
}
