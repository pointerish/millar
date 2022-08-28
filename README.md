# Millar

Millar is an Elixir application that fetches SCP foundation articles, stores them into an ETS table and makes them available through the `/scps/:scp_number` endpoint on port `13000`.
The idea is to create a catalogue, so in this sense, the ETS table will likely get replaced by either DETS or SQLite.

## Plans for the future

I plan to create an Emacs package to access Millar's catalogue. 

