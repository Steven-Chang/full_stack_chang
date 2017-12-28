//= require spec_helper

describe("linkFilter", function(){

	it("adds a 'http://' to a link if it doesn't start with http or https", function(){
		var url = "www.google.com";
		expect( $filter( 'linkFilter' )( url ) ).toEqual( "https://www.google.com" );
	});

	it("swaps out a 'http://' with a 'https://", function(){
		var url = "http://www.google.com";
		expect( $filter( 'linkFilter' )( url ) ).toEqual( "https://www.google.com" );
	});

	it("doesn't add change anything if the link already starts with a 'https://'", function(){
		var url = "https://www.google.com";
		expect( $filter( 'linkFilter' )( url ) ).toEqual( url );
	});
});