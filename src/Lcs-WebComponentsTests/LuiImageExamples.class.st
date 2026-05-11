Class {
	#name : 'LuiImageExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiImageExamples >> newComponent [
	<gtExample>
	| component |
	component := (LuiImage named: 'exampleImage').	
	self assert: component componentName = 'exampleImage'.
	self assert: component hasNoComponents.
	self assert: component title isNil.
	self assert: component altText isNil.
	self assert: component url isNil.
	^ component
]

{ #category : 'examples' }
LuiImageExamples >> renderedSeasideImage [
	<gtExample>
	"No id is in the html because the id is calculated
	 when the component is added to its parent"
	^ self
		assertRendered: self seasideImageComponent
		equals: '<img alt="the Seaside logo" name="exampleImage" data-StClass="LuiImage" title="Seaside" class="logo" src="http://www.seaside.st/logo.jpeg"/>'
]

{ #category : 'examples' }
LuiImageExamples >> seasideImageComponent [
	<gtExample>
	| component |
	component := (LuiImage named: 'exampleImage')
					cssClass: 'logo';
					title: 'Seaside';
					altText: 'the Seaside logo';
					url: 'http://www.seaside.st/logo.jpeg'.	
	self assert: component title equals: 'Seaside'.
	self assert: component altText equals: 'the Seaside logo'.
	self assert: component url equals: 'http://www.seaside.st/logo.jpeg'.
	self assert: component cssClassesString equals: 'logo'.
	self assertRendered: component equals: '<img alt="the Seaside logo" name="exampleImage" data-StClass="LuiImage" title="Seaside" class="logo" src="http://www.seaside.st/logo.jpeg"/>'.
	^ component
]
