FROM ubuntu:jammy
COPY . .

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget unzip python3 python3-pip p7zip

RUN mv config.yml.default config.yml
RUN wget https://abrok.eu/stockfish/latest/linux/stockfish_x64_bmi2.zip -O stockfish.zip
RUN unzip stockfish.zip && rm stockfish.zip
RUN mv stockfish_* engines/stockfish && chmod +x engines/stockfish

RUN wget -U "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36" --no-check-certificate "https://onedrive.live.com/download?cid=547CCA53C39C1EA1&resid=547CCA53C39C1EA1%21599&authkey=AMLXM4n_ZwOk7VQ" -O cubail.7z
RUN 7zr e cubail.7z && rm cubail.7z

#RUN wget --no-check-certificate "https://tests.stockfishchess.org/api/nn/nn-152a10c3e3b0.nnue" -O nn-152a10c3e3b0.nnue
#RUN mv nn-152a10c3e3b0.nnue engines/nn-152a10c3e3b0.nnue

RUN python3 -m pip install --no-cache-dir -r requirements.txt

# Add the "--matchmaking" flag to start the matchmaking mode.
CMD python3 user_interface.py --non_interactive
