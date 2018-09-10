<template>
  <section id='register'>
    <h1>Register</h1>
    <form class="form">
      <!--TODO: Add password validation: https://jsfiddle.net/kazupon/kdvdvdze/7/-->
      <!--<div class="input-group">-->
        <!--<label for="username" class="form-label">Username</label>-->
        <!--<input id="username" name="username" class="form-input"-->
               <!--v-model="username" v-bind:class="{ unavailable: isUnavailable}">-->
      <!--</div>-->

      <InputField placeholder="Username"></InputField>

      <div class="input-group dif">
        <label @focus="addFocused" class="form-label"
               for="password">Password</label>
        <input
          id="password" type="password"
          name="password"
          ref="passInput"
          v-model="password"
          v-bind:style="classObject"
          class="form-input">

        <div id="pass-strength-emoji" v-if="password !== '' ">{{activeEmoji}}
        </div>
      </div>
      <div class="input-group">
        <label @focus="" class="form-label"
               for="password_confirm">Confirm</label>
        <input id="password_confirm" type="password" name="password_confirm"
               v-model="confirmPassword" class="form-input">
      </div>
      <button @click="registerUser" name="register">Register</button>
    </form>
  </section>
</template>

<script>
  import Registrar from '@/js/registrar'
  import _ from 'lodash'
  import Utils from '@/js/utils'
  import InputField from './InputField'

  export default {
    name: 'register',
    components: {InputField},
    data () {
      return {
        isUnavailable: undefined,
        username: undefined,
        password: '',
        passwordFocused: false,
        confirmPassword: undefined,
        strengthColors: ['darkred', 'red', 'yellow', 'green'],
        strengthEmojis: ['🤢', '😳', '🙃', '🤩']
      }
    },

    watch: {
      username: function (newUsername, oldUsername) {
        this.debouncedValidateUsername()
      }
    },

    beforeCreate: function () {
      Registrar.init()
      // TODO: Might need to init the PassMan Contract as well
    },

    created: function () {
      this.debouncedValidateUsername = _.debounce(this.validateUserName, 500)
    },

    computed: {
      activeColor: function () {
        console.log(Utils.entropyIsSufficient(this.password).score)
        return this.strengthColors[Utils.entropyIsSufficient(this.password).score]
      },
      activeEmoji: function () {
        return this.strengthEmojis[Utils.entropyIsSufficient(this.password).score]
      },
      passInputEmpty: function () {
        if (!this.$refs.passInput) return
        console.log(this.$refs.passInput.value === '')
        return !this.$refs.pass_input.value === ''
      },
      // TODO: Change name
      classObject: function () {
        if (this.password === '') return
        return {
          'border-bottom-color': this.strengthColors[Utils.entropyIsSufficient(this.password).score],
          'color': this.strengthColors[Utils.entropyIsSufficient(this.password).score]
        }
      }
    },

    methods: {

      validateUserName: async function () {
        let exists = await Registrar.userExists(this.username)
        this.isUnavailable = exists
        if (exists) {
          console.log('Unavailable')
        } else {
          console.log('Available')
        }
        // Registrar.userExists(this.username).then((exists) => {
        //   if (exists) {
        //     console.log('Unavailable')
        //   } else {
        //     console.log('Available')
        //   }
        // })
      },

      validatePasswordStrength: function () {
      },

      registerUser: function () {
        console.log(this.$refs)
      },

      addFocused: function () {
        this.parents
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import url('https://fonts.googleapis.com/css?family=Montserrat');

  #register {
    text-align: center;
    padding: 0 20%;

    .form {
      padding-top: 15vh;
      .entry {
        /*display: flex;*/
        /*flex-direction: column;*/
        /*justify-content: center;*/
        /*width: 50%;*/
        /*margin: auto;*/
        font-family: 'Montserrat', sans-serif;

        label {
          margin-right: 20px
        }

        button {
          margin: 20px
        }
        input {
          border-left: none;
          border-right: none;
          border-top: none;
          border-bottom: 1px solid lightgrey;
          outline: none;
          width: 50%;
          transform: translateX(50%);
          margin: 10px 0;
          font-size: 20px;
        }
        input:focus {
          border-bottom-color: black;
        }
      }

    }

  }

  .unavailable {
    border-bottom-color: red !important;
  }

  .dif {


    #pass-strength-emoji {
      position: absolute;
      transform: translateX(38vw);
      padding: 10px 0;
    }
  }

  .input-group {
    position: relative;
    width: 100%;

    input {
      font-size: 5vw;
    }

    label {
      font-size: 5vw;
    }

    .form-submit {
      border: none;
      background: none;
      padding: 10px;
      border-radius: 5px;
      //background: #849ea257;
    }
  }

  .form-label {
    position: absolute;
    left: 0;
    top: 10px;
    color: #999;
    background-color: #fff;
    z-index: 10;
    transition: font-size 150ms ease-out, -webkit-transform 150ms ease-out;
    transition: transform 150ms ease-out, font-size 150ms ease-out;
    transition: transform 150ms ease-out, font-size 150ms ease-out, -webkit-transform 150ms ease-out;
  }

  .focused .form-label {
    -webkit-transform: translateY(-125%);
    transform: translateY(-125%);
    font-size: .75em;
  }

  .form-input {
    position: relative;
    padding: 20px 0px 25px 0;
    width: 100%;
    outline: 0;
    border: 0;
    box-shadow: 0 1px 0 0 #e5e5e5;
    transition: box-shadow 150ms ease-out;
  }

  .input-group + .input-group {
    margin-top: 50px;
  }

  body {
    margin: 0;
  }

</style>
