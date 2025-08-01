Class {
	#name : #LcsAddSlotDefinitionFormElement,
	#superclass : #BrStencil,
	#instVars : [
		'parentElement',
		'element',
		'formCache',
		'targetClass'
	],
	#category : #'Lcs-Magritte-Base-UI'
}

{ #category : #'instance creation' }
LcsAddSlotDefinitionFormElement class >> newOn: aParentElement targetClass: aClass [
	^ self new
		initializeOn: aParentElement targetClass: aClass;
		yourself
]

{ #category : #accessing }
LcsAddSlotDefinitionFormElement >> element [
	^ element
]

{ #category : #accessing }
LcsAddSlotDefinitionFormElement >> element: anObject [
	element := anObject
]

{ #category : #accessing }
LcsAddSlotDefinitionFormElement >> formCache [
	^ formCache
]

{ #category : #accessing }
LcsAddSlotDefinitionFormElement >> formCache: anObject [ 
	formCache := anObject 
]

{ #category : #'gt views' }
LcsAddSlotDefinitionFormElement >> gtCreationInterface: aParentElement [
	| contentTabs |
	contentTabs := BrTabGroup new.
	contentTabs aptitude: BrGlamorousTabGroupAptitude new.
	contentTabs
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	self tabClasses do: [ :each | 
		contentTabs addTab: (
			BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: each slotComponentName;
				stencil: [ 
					(self formCache
						at: each
						ifAbsentPut: [ | form |
							form := (each newOn: self targetClass)
											onReset: [ aParentElement
													inUIProcessDo: [ aParentElement fireEvent: BrDropdownHideWish new.
														self formCache removeKey: each ] ].
									"form class == GtClassCreationForm
										ifTrue: [ navigationModel
												selectedClassDo: [ :aClass | aClass isClass ifTrue: [ form superclassName: aClass name ] ] ]."
									"form hasPackageAndTag
										ifTrue: [ navigationModel
												selectedPackageDo: [ :aPackage | form packageAndTagName packageName: aPackage name ].
											navigationModel
												selectedTagDo: [ :aTag | 
													(aTag isKindOf: RPackageTag)
														ifTrue: [ aTag isRoot ifFalse: [ form packageAndTagName tagName: aTag name ] ]
														ifFalse: [ aTag isUncategorized ifFalse: [ form packageAndTagName tagName: aTag name ] ] ] ]."
							((GtCreationFormWidget forForm: form)
										onAccept: [ :anInstance | 
											aParentElement
												inUIProcessDo: [ "form selectInNavigationModel: navigationModel anInstance: anInstance."
													aParentElement fireEvent: BrDropdownHideWish new ].
											self formCache removeKey: each ifAbsent: [  ] ]) asElement ])
					removeFromParent ]) ].
	^ contentTabs
]

{ #category : #initialize }
LcsAddSlotDefinitionFormElement >> initialize [ 
	super initialize.
	self formCache: Dictionary new
]

{ #category : #initialize }
LcsAddSlotDefinitionFormElement >> initializeOn: aParentElement targetClass: aClass [ 
	self taregtClass: aClass.
	self parentElement: aParentElement.
	self element: BlElement new.
	self element
		constraintsDo: [ :c | 
			c horizontal exact: 400.
			c vertical exact: 300 ].
	self element addChild: (self gtCreationInterface: self parentElement).
	self parentElement
		when: GtNavigationDropDownCreateWish
		do: [ :aWish | self element children first selectTabWithLabelString: aWish tabName ]

]

{ #category : #accessing }
LcsAddSlotDefinitionFormElement >> parentElement [
	^ parentElement
]

{ #category : #accessing }
LcsAddSlotDefinitionFormElement >> parentElement: anObject [
	parentElement := anObject
]

{ #category : #'gt views' }
LcsAddSlotDefinitionFormElement >> tabClasses [
	^ (LcsSlotCreationForm allSubclasses
		select: [ :aClass | 
			(aClass isAbstract or: [ aClass hasAbstractMethods ]) not
				and: [ aClass isAdditionForm ] ])
		asSortedCollection: [ :a :b | a priority < b priority ]
]

{ #category : #accessing }
LcsAddSlotDefinitionFormElement >> taregtClass: aClass [ 
	targetClass := aClass
]

{ #category : #accessing }
LcsAddSlotDefinitionFormElement >> targetClass [
	^ targetClass
]
