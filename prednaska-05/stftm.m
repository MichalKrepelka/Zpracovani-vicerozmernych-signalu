function S = stftm(X, hop, N, window)
    % Provede stft pro vsechny senzory.
    % X - signal ze senzoru
    % hop - posun dvou okenek (odvozuji z nej overlap)
    % N - parametr FFTLength stft
    % window - synthesis window delky N
    % vraci S -nastackovane vysledky stft pro jednotlive senzory 
    
    overlap = N - hop;  % prekryv dvou okenek

    no_sensors = size(X,1);
    no_frames = floor(1+((size(X,2)-N)/hop));
    no_frequencies = N;
    S = zeros(no_sensors, no_frequencies, no_frames);
    for i=1:no_sensors
        S(i,:,:) = stft(X(i,:), 'OverlapLength', overlap, 'FFTLength', N, 'Window', window);
    end
end

