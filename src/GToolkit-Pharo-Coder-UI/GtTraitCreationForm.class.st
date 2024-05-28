Class {
	#name : #GtTraitCreationForm,
	#superclass : #GtBehaviorCreationForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtTraitCreationForm class >> componentName [
	^ 'Trait'
]

{ #category : #accessing }
GtTraitCreationForm >> commit [
	| tmp1 tmp2 |
	tmp1 := self commitPackage categoryName.
	tmp2 := Smalltalk classInstaller
			make: [ :arg1 | 
				arg1
					name: newClassName;
					category: tmp1;
					slots: slots;
					traitComposition: self traitComposition;
					beTrait ].
	self installClassSlotsOn: tmp2.
	^ tmp2
]

{ #category : #accessing }
GtTraitCreationForm >> defaultName [
	^ 'TNameOfTrait'
]
