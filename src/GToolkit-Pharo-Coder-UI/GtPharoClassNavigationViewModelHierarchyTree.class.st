Class {
	#name : #GtPharoClassNavigationViewModelHierarchyTree,
	#superclass : #Object,
	#instVars : [
		'rootClass',
		'subclassTrees'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #factory }
GtPharoClassNavigationViewModelHierarchyTree class >> fromWithPharoBehaviorCoderModels: arg1 [
	| tmp1 tmp2 tmp3 tmp4 |
	tmp1 := self new.
	tmp2 := arg1 asSet.
	tmp3 := tmp2
			reject: [ :arg2 | 
				tmp2
					anySatisfy: [ :arg3 | self isWithPharoBehaviorCoderModel: arg2 inheritsFrom: arg3 ] ]
			thenCollect: [ :arg4 | 
				arg4
					-> (tmp2
							select: [ :arg5 | self isWithPharoBehaviorCoderModel: arg5 inheritsFrom: arg4 ]) ].
	tmp4 := tmp3
			collect: [ :arg6 | (self fromWithPharoBehaviorCoderModels: arg6 value) rootClass: arg6 key ]
			as: Array.
	tmp1 subclassTrees: tmp4.
	^ tmp1
]

{ #category : #'private - testing' }
GtPharoClassNavigationViewModelHierarchyTree class >> isWithPharoBehaviorCoderModel: arg1 inheritsFrom: arg2 [
	^ arg1 pharoBehaviorCoderModel behavior
		inheritsFrom: arg2 pharoBehaviorCoderModel behavior
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> at: arg1 [
	<return: #GtCoderClassesHierarchyTree>
	^ self subclassTrees at: arg1
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> classes [
	<return: #Collection of: #Class>
	^ self subclassTrees collect: [ :arg1 | arg1 rootClass ]
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> first [
	<return: #GtCoderClassesHierarchyTree>
	^ self at: 1
]

{ #category : #'gt-extension' }
GtPharoClassNavigationViewModelHierarchyTree >> gtTreeFor: arg1 [
	<gtView>
	| tmp2 |
	tmp2 := arg1 tree.
	tmp2
		title: 'Classes';
		priority: 1;
		items: [ {self} ];
		children: [ :arg2 | arg2 subclassTrees ].
	^ tmp2 expandUpTo: 1
]

{ #category : #testing }
GtPharoClassNavigationViewModelHierarchyTree >> hasRootClass [
	<return: #Boolean>
	^ rootClass isNotNil
]

{ #category : #initialization }
GtPharoClassNavigationViewModelHierarchyTree >> initialize [
	super initialize.
	subclassTrees := Array empty
]

{ #category : #printing }
GtPharoClassNavigationViewModelHierarchyTree >> printOn: arg1 [
	self hasRootClass
		ifTrue: [ arg1 print: self rootClass ]
		ifFalse: [ arg1 nextPutAll: 'Classes' ].
	self size isZero
		ifFalse: [ arg1
				space;
				nextPut: $(;
				print: self size;
				nextPut: $) ]
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> rootClass [
	<return: #Behavior>
	^ rootClass
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> rootClass: arg1 [
	rootClass := arg1
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> size [
	<return: #Number>
	^ subclassTrees size
]

{ #category : #sorting }
GtPharoClassNavigationViewModelHierarchyTree >> sort: arg1 [
	subclassTrees := subclassTrees
			sorted: [ :arg2 :arg3 | arg1 value: arg2 rootClass value: arg3 rootClass ].
	subclassTrees do: [ :arg4 | arg4 sort: arg1 ]
]

{ #category : #sorting }
GtPharoClassNavigationViewModelHierarchyTree >> sortByClassName [
	self sort: [ :arg1 :arg2 | arg1 name < arg2 name ]
]

{ #category : #accessing }
GtPharoClassNavigationViewModelHierarchyTree >> subclassTrees [
	<return: #Collection of: #GtCoderClassesHierarchyTree>
	^ subclassTrees
]

{ #category : #initialization }
GtPharoClassNavigationViewModelHierarchyTree >> subclassTrees: arg1 [
	subclassTrees := arg1
]
