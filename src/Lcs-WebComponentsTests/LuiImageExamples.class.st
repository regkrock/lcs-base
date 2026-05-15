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
	self assertRendered: component equals: '<img alt="" name="exampleImage" data-StClass="LuiImage"/>'.
	^ component
]

{ #category : 'examples' }
LuiImageExamples >> seasImageComponent [
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

{ #category : 'examples' }
LuiImageExamples >> seasImageComponentWithoutAltText [
	<gtExample>
	| component |
	component := (LuiImage named: 'exampleImage')
					cssClass: 'logo';
					title: 'Seaside';
					url: 'http://www.seaside.st/logo.jpeg'.	
	self assert: component title equals: 'Seaside'.
	self assert: component altText isNil.
	self assert: component url equals: 'http://www.seaside.st/logo.jpeg'.
	self assert: component cssClassesString equals: 'logo'.
	self assert: (component attributes attributeNamed: 'altText') isNil.
	self assertRendered: component equals: '<img alt="" name="exampleImage" data-StClass="LuiImage" title="Seaside" class="logo" src="http://www.seaside.st/logo.jpeg"/>'.
	^ component
]

{ #category : 'examples' }
LuiImageExamples >> seasideImageComponent [
	<gtExample>
	| component |
	component := (LuiImage named: 'logo')
					cssClass: 'logo';
					title: 'Seas Monmouth';
					altText: 'The Seas Monmouth logo';
					url: LcsFileLibrary / #favicon.	
	self assert: component title equals: 'Seas Monmouth'.
	self assert: component altText equals: 'The Seas Monmouth logo'.
	self assert: component url printString equals: '/files/LcsFileLibrary/favicon'.
	self assert: component cssClassesString equals: 'logo'.
	self assertRendered: component equals: '<img alt="The Seas Monmouth logo" name="logo" data-StClass="LuiImage" title="Seas Monmouth" class="logo" src="/files/LcsFileLibrary/favicon"/>'.
	^ component
]
