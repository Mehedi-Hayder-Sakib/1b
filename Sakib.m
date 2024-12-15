% Voice to Audio Spectrum Project
fs = 44100; % Sampling frequency
duration = 5; % Recording duration in seconds

% Step 1: Record Audio
recObj = audiorecorder(fs, 16, 1); % Create an audio recorder object
disp('Start speaking...');
recordblocking(recObj, duration); % Record audio
disp('Recording complete.');

% Get audio data from the recorder
audioData = getaudiodata(recObj);

% Step 2: Plot Spectrogram
figure;
subplot(3, 1, 1); % Allocate space for three plots
spectrogram(audioData, 256, 128, 256, fs, 'yaxis'); % Plot spectrogram
title('Spectrogram');
ylabel('Frequency (kHz)');
xlabel('Time (s)');
colorbar;

% Step 3: Plot Time-Domain Signal
subplot(3, 1, 2);
t = (0:length(audioData)-1) / fs; % Time vector
plot(t, audioData, 'b');
title('Time-Domain Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Step 4: Compute and Plot Frequency Spectrum
n = length(audioData); % Number of samples
fftData = fft(audioData); % Perform FFT
magnitude = abs(fftData(1:floor(n/2))); % Magnitude of FFT
frequencies = linspace(0, fs/2, floor(n/2)); % Frequency range (positive half)

subplot(3, 1, 3);
plot(frequencies, magnitude, 'r');
title('Frequency Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Step 5: Save Audio File (Optional)
audiowrite('recorded_voice.wav', audioData, fs);
disp('Audio saved as recorded_voice.wav');
