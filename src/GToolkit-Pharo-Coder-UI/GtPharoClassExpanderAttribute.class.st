Class {
	#name : #GtPharoClassExpanderAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'classToExpand'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Attributes'
}

{ #category : #'initialize-release' }
GtPharoClassExpanderAttribute class >> forClass: arg1 [
	| tmp2 |
	tmp2 := self new.
	tmp2 forClass: arg1.
	^ tmp2 yourself
]

{ #category : #private }
GtPharoClassExpanderAttribute >> buildBehaviorCoder [
	| tmp1 tmp3 |
	tmp1 := GtCoderElement forClass: classToExpand.
	tmp1 background: Color white.
	tmp3 := BrGlamorousWithVerticalResizerAptitude new.
	tmp3 beBottom.
	tmp1
		aptitude: BrShadowAptitude + tmp3 yourself;
		height: 400;
		margin: (BlInsets
					top: 3
					right: 10
					bottom: 10
					left: 10).
	^ tmp1
]

{ #category : #accessing }
GtPharoClassExpanderAttribute >> expandedClass [
	^ classToExpand
]

{ #category : #'initialize-release' }
GtPharoClassExpanderAttribute >> forClass: arg1 [
	classToExpand := arg1
]

{ #category : #'initialize-release' }
GtPharoClassExpanderAttribute >> initialize [
	super initialize.
	self
		attributesCreatingBlock: [ | tmp2 |
			tmp2 := BrTextAdornmentDynamicAttribute new.
			tmp2
				beAppend;
				stencil: [ self buildBehaviorCoder ] ]
]
