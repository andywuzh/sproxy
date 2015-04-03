all: compile

compile:
	./rebar compile

clean:
	./rebar -r clean

release:
	cd rel && ../rebar generate