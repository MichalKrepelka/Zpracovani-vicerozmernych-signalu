function X = istftm(S, hop, N, window)
    % Provede inverzni stft pro vsechny senzory.
    % S - nastackovane vysledky stft pro jednotlive senzory
    % hop - posun dvou okenek (odvozuji z nej overlap)
    % N - parametr FFTLength stft
    % window - synthesis window delky N
    % vraci X - signaly pro jednotlive senzory

    overlap = N - hop;  % prekryv dvou okenek
    no_sensors = size(S, 1);
    noFrames = size(S, 3);
    Xlen = noFrames*hop+(N-hop);
    
    X = zeros(no_sensors, Xlen);
     
    for i=1:no_sensors
        S_sensor = S(i,:,:);
        X(i,:) = istft(squeeze(S_sensor), 'OverlapLength', overlap, 'FFTLength', N, 'Window', window);
    end
end

