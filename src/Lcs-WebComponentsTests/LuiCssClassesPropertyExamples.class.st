Class {
	#name : 'LuiCssClassesPropertyExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LuiCssClassesPropertyExamples >> testAddingCssClass [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesProperty new.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.
	self assert: cssClassesProperty cssClasses first equals: 'testClass'.
	self assert: cssClassesProperty cssClassesString = 'testClass'.
	cssClassesProperty addCssClass: 'testClass2'.
	self assert: cssClassesProperty cssClassesString = 'testClass testClass2'.
]

{ #category : 'tests' }
LuiCssClassesPropertyExamples >> testAddingDuplicateCssClass [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesProperty new.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.

]

{ #category : 'tests' }
LuiCssClassesPropertyExamples >> testCreation [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesProperty new.
	self assert: cssClassesProperty cssClasses isEmpty.
	self assert: cssClassesProperty cssClassesString isEmpty
]

{ #category : 'tests' }
LuiCssClassesPropertyExamples >> testCssClassString [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesProperty new.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty cssClassesString isEmpty.
	self assert: cssClassesProperty propertyValue isEmpty.
	
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty cssClassesString equals: 'testClass'.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty propertyValue equals: 'testClass'.
	self assert: cssClassesProperty propertyValue equals: cssClassesProperty cachedValue.

	cssClassesProperty removeCssClass: 'testClass'.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty cssClassesString isEmpty.
	self assert: cssClassesProperty propertyValue isEmpty.

]

{ #category : 'tests' }
LuiCssClassesPropertyExamples >> testRemovingCssClass [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesProperty new.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.
	cssClassesProperty removeCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses isEmpty. 
]
