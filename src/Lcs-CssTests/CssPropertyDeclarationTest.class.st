Class {
	#name : #CssPropertyDeclarationTest,
	#superclass : #TestCase,
	#category : #'Lcs-CssTests-Tests'
}

{ #category : #test }
CssPropertyDeclarationTest >> testPropertyDeclaration [
	| declaration |
	declaration := CssPropertyDeclaration new 
					propertyName: 'color';
					propertyValue: 'red';
					yourself.
	self assert: declaration propertyName = 'color'.
	self assert: declaration propertyValue = 'red'.
	self assert: declaration prettyCssString equals: 'color: red;'.
	self assert: declaration compressedCssString equals: 'color:red;'
]
